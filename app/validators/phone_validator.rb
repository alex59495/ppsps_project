class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # (?:(?:\+|00)33|0)     # Dialing code
    # \s*[1-9]              # First number (from 1 to 9)
    # (?:[\s.-]*\d{2}){4}   # End of the phone number
    unless value =~ /(?:(?:\+|00)33|0)\s*[1-9](?:[\s.-]*\d{2}){4}/
      record.errors[attribute] << (options[:message] || "n'est pas un téléphone valide")
    end
  end
end