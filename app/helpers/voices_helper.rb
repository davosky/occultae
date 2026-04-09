module VoicesHelper
  def value_type_image(voice)
    if voice.gruppo?
      image_tag "voices/voices-icon-value-group.svg", size: "60x20"
    elsif voice.bottone? && voice.si?
      image_tag "voices/voices-icon-value-yes.svg", size: "60x20"
    elsif voice.bottone? && voice.no?
      image_tag "voices/voices-icon-value-no.svg", size: "60x20"
    end
  end

  def submit_button
    if action_name == "new"
      "btn btn-success"
    else
      "btn btn-warning"
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
