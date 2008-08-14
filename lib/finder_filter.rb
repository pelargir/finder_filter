module FinderFilter
  def finder_filter(*args)
    options = args.extract_options!
    name = args.empty? ? controller_name.singularize : args.first
    by = options.delete(:by)
    param = options.delete(:param) || :id
    prepend = options.delete(:prepend) || false
    
    send(prepend ? :prepend_before_filter : :before_filter, :"find_#{name}", options)
    
    define_method "find_#{name}" do
      klass = name.to_s.classify.constantize
      item = by ? klass.send("find_by_#{by}", params[param]) : klass.find(params[param])
      instance_variable_set("@#{name}", item)
    end
  end
end

ActionController::Base.extend FinderFilter