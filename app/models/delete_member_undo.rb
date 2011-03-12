class DeleteMemberUndo < UndoItem
  def process!
    raise('Member already exists') if Member.find_by_id(loaded_data.delete('id').to_i)

    member = nil
    transaction do
      member = Member.create!(loaded_data)
      self.destroy
    end
    member
  end

  def loaded_data
    @loaded_data ||= YAML.load(data)
  end

  def description
    "Deleted member '#{loaded_data['username']}'"
  end

  def complete_description
    "Recreated member '#{loaded_data['username']}'"
  end

  class << self
    def create_undo(page)
      DeleteMemberUndo.create!(:data => member.attributes.to_yaml)
    end
  end
end
