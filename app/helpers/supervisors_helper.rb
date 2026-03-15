module SupervisorsHelper
  def supervisor_avatar
    if current_supervisor.gender == "F"
      image_tag("supervisors/supervisors-female-logo.svg", class: "img-fluid", size: "58x58", alt: "logo")
    elsif current_supervisor.gender == "M"
      image_tag("supervisors/supervisors-male-logo.svg", class: "img-fluid", size: "58x58", alt: "logo")
    else
      image_tag("supervisors/supervisors-neutral-logo.svg", class: "img-fluid", size: "58x58", alt: "logo")
    end
  end
end
