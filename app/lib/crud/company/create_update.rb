module CRUD
  module Company
    class CreateUpdate
      #Used to create and update company registration details

      def create_address_detail options
        st = State.find_or_create_by(name: options[:state])
        city = City.find_or_create_by(name: options[:town_city],state_id: st.id)
        pincode = Pincode.find_or_create_by(pincode: options[:pincode],city_id: city.id)
        pincode
      end

      def register options
        ApplicationRecord.connection.transaction do
          cd = CompanyDetail.create_new_company_detail options
          options[:company_detail_id] = cd.id
          CompanyDetailUser.create_new_company_detail_user options
          ContactDetail.create_new_contact_detail options
          pincode = create_address_detail options
          options[:pincode_id] = pincode.id
          HeadquaterAddress.create_new_headquater options
        end
      end
    end
  end
end
