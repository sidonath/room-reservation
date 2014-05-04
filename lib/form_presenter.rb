class FormPresenter
  include Lotus::Presenter

  def error_class(key)
    return nil if errors[key.to_sym].empty?
    'error'
  end

  def errors_for(key, &block)
    errors = self.errors[key.to_sym]
    return if errors.empty?

    yield errors.join(', ')
  end
end
