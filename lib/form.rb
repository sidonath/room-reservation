class Form < Reform::Form
  def validate(params, listener)
    return if super(params.stringify_keys)

    listener.form_invalid
  end

  def populate(*args)
    validate(*args)
    if valid?
      save
    end
    model
  end
end
