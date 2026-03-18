module NodesHelper
  def submit_button
    if action_name == "new"
      "btn btn-success fs-6 fw-bold"
    else
      "btn btn-warning fs-6 fw-bold"
    end
  end

  def form_elements_class
    if action_name == "new"
      "bg-success text-white fs-4 fw-bold"
    else
      "bg-warning text-white fs-4 fw-bold"
    end
  end

  def form_texts_class
    if action_name == "new"
      "text-success fs-4 fw-bold"
    else
      "text-warning fs-4 fw-bold"
    end
  end

  def enabled(node)
    if node.general.enabled == true
      "<i class='fa-solid fa-square-check text-success'></i>".html_safe
    else
      "<i class='fa-solid fa-square-xmark text-danger'></i>".html_safe
    end
  end

  def login_enabled(node)
    if node.general.login_enabled == true
      "<i class='fa-solid fa-square-check text-success'></i>".html_safe
    else
      "<i class='fa-solid fa-square-xmark text-danger'></i>".html_safe
    end
  end
end
