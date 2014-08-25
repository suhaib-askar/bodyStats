module ActivitiesHelper

  def link_to_trackable(object, object_type)
    if object
      link_to object_type.downcase, "object"
    else
      "a #{object_type.downcase} which does not exist anymore"
    end
  end

  def whose?(user, object)
    case object
    when Post
      owner = object.author
    when Comment
      owner = object.user
    else
      owner = nil
    end
    if user and owner
      if user.id == owner.id
        "his"
      else
        "#{owner.nickname}'s"
      end
    else
      ""
    end
  end

  def activity_time(obj, options={type: :full})
    type = options[:type]
    return "#{time_ago_in_words(obj.created_at)} ago" if type == :short
    "#{time_ago_in_words(obj.created_at)} ago - #{obj.created_at.strftime("%d %b. %Y, %H:%M")}"
  end
end
