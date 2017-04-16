module AttributeAssignment
  def assign_attributes(attributes = {})
    attributes.each do |attr, value|
      self.public_send("#{attr}=", value)
    end if attributes
  end
end
