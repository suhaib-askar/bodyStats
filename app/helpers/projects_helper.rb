module ProjectsHelper

  def unit(unit_id)
    Unit.find(unit_id).send("short_#{I18n.locale}")
  end

end
