class Form < Reform::Form
  def validate(params, listener=nil)
    return true if super(params.stringify_keys)

    if listener
      listener.form_invalid
    end

    false
  end

  def populate(*args)
    validate(*args)
    if valid?
      save
    end
    model
  end
end
