module TrackItemsHelper

  def unit_name(id, &block) 
    obj = Unit.find(1)
    block.call(obj.full_en)
  end

end
