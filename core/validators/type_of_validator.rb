class TypeOfValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    klass_name = options[:klass_name]
    is_type_of = record.send(attribute).instance_of?(klass_name.constantize)
    unless is_type_of
      record.errors.add(attribute, "is an invalid type")
    end
  end
end
