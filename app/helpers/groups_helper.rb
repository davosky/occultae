module GroupsHelper
  def submit_button
    if action_name == "new"
      "btn btn-success"
    else
      "btn btn-warning"
    end
  end

  def submit_button_text
    if action_name == "new"
      "Crea"
    else
      "Modifica"
    end
  end

  def form_elements_class
    if action_name == "new"
      "bg-success text-white"
    else
      "bg-warning text-white"
    end
  end

  def form_texts_class
    if action_name == "new"
      "text-success"
    else
      "text-warning"
    end
  end
end
