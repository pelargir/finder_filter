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
      if nested && params.include?("#{nested}_id")
        nested_klass = nested.to_s.classify.constantize
        nested_param = "#{nested}_id".intern
        
        if nested_klass.method_defined? :param_column
          nested_item = nested_klass.from_param(params[nested_param])
        else
          nested_item = by ? nested_klass.send("find_by_#{by}", params[nested_param]) : nested_klass.find(params[nested_param])
        end
        if klass.method_defined? :param_column
          item = nested_item.send(name.to_s.pluralize).from_param(params[param])
        else
          item = by ? nested_item.send(name.to_s.pluralize).send("find_by_#{by}", params[param]) : nested_item.send(name.to_s.pluralize).find(params[param])
        end
        instance_variable_set("@#{nested}", nested_item)
      else
        if klass.method_defined? :param_column
          item = klass.from_param(params[param])
        else
          item = by ? klass.send("find_by_#{by}", params[param]) : klass.find(params[param])
        end
      end
      instance_variable_set("@#{name}", item)
    end
  end
end

ActionController::Base.extend FinderFilter