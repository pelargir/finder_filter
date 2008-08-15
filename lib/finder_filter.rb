module FinderFilter
  def finder_filter(*args)
    options = args.extract_options!
    name = args.empty? ? controller_name.singularize : args.first
    by, nested = options.delete(:by), options.delete(:nested)
    param = options.delete(:param) || :id
    prepend = options.delete(:prepend) || false
    
    filter_method = prepend ? :prepend_before_filter : :before_filter
    send(filter_method, "find_#{name}".intern, options)
    
    define_method "find_#{name}" do
      klass = name.to_s.classify.constantize
      if nested
        nested_klass = nested.to_s.classify.constantize
        nested_param = "#{nested}_id".intern
                
        nested_item = by ? nested_klass.send("find_by_#{by}", params[nested_param]) : nested_klass.find(params[nested_param])
        item = by ? nested_item.send(name.to_s.pluralize).send("find_by_#{by}", params[param]) : nested_item.send(name.to_s.pluralize).find(params[param])
        instance_variable_set("@#{nested}", nested_item)
      else
        item = by ? klass.send("find_by_#{by}", params[param]) : klass.find(params[param])
      end
      instance_variable_set("@#{name}", item)
    end
  end
end

ActionController::Base.extend FinderFilter