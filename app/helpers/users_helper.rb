module UsersHelper
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

  def user_voice_access(voice, user, user_group_ids)
    if voice.bottone?
      voice.si?
    elsif voice.gruppo?
      voice.user_ids.include?(user.id) ||
        (user_group_ids.present? && (voice.group_ids & user_group_ids).any?)
    else
      false
    end
  end

  def user_voice_access_groups(voice, user_group_ids)
    return [] unless voice.gruppo?
    voice.groups.select { |g| user_group_ids.include?(g.id) }
  end

  def user_voice_access_users(voice, user)
    return [] unless voice.gruppo?
    voice.users.select { |u| u.id == user.id }
  end

  def node_access_mode(node, user)
    direct = node.user_ids.include?(user.id)
    via_groups = node.groups.select { |g| user.group_ids.include?(g.id) }
    { direct: direct, via_groups: via_groups }
  end

  def user_avatar(user)
    if user.gender == "F"
      image_tag("users/users-female-logo.svg", class: "img-fluid", size: "48x48", alt: "logo")
    elsif user.gender == "M"
      image_tag("users/users-male-logo.svg", class: "img-fluid", size: "48x48", alt: "logo")
    else
      image_tag("users/users-neutral-logo.svg", class: "img-fluid", size: "48x48", alt: "logo")
    end
  end
end
