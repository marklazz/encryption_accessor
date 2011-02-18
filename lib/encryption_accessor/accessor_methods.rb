module EncryptionAccessor

  module AccessorMethods

    def encryption_accessor(*fields)
      fields.each do |field|
        force_implement_field_setter!(field)

        define_method(:"#{field}_with_encryption=") do |value|
          self.send(:"#{field}_without_encryption=", value)
          write_attribute(:"#{field}", AESCrypt.encrypt(read_attribute(:"#{field}"))) unless value.nil?
        end

        self.send :alias_method_chain, :"#{field}=", :encryption

        define_method(:"#{field}_decrypt") do
          blob_value = self.read_attribute(:"#{field}")
          return if blob_value.nil?
          AESCrypt.decrypt(blob_value)
        end

        define_method(:"#{field}") do
          self.send(:"#{field}_decrypt")
        end

        define_method(:"#{field}_encrypted") do
          self.attributes["#{field}"]
        end
        define_method(:"#{field}") do
          self.send(:"#{field}_decrypt")
        end
        define_method(:"#{field}_encrypt!") do
          self.send(:"#{field}_with_encryption=", self.attributes["#{field}"])
        end
        define_method(:"#{field}_decrypt!") do
          self.send(:"#{field}=", self.send(:"#{field}_decrypt"))
        end
      end
    end

    private

    def force_implement_field_setter!(field)
      new.send("#{field}=", nil)
    end
  end
end

module ActiveRecord
  class Base
   class << self
     include EncryptionAccessor::AccessorMethods
    end
  end
end
