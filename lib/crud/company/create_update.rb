module CRUD
  module Company
    class CreateUpdate
      def create_company_details options
        cd = CompanyDetail.new
        cd.name = options[:company_name]
        cd.annual_revenue = options[:annual_revenue]
        cd.no_of_employees = options[:no_of_employees]
        cd.save!
        cd
      end

      def create_company_detail_user options
        cdu = CompanyDetailUser.new
        cdu.user_id = options[:user_id]
        cdu.company_detail_id = options[:company_detail_id]
        cdu.save!
        cdu
      end

      def create_headquaters options
        ha = HeadquaterAddress.new
        ha.company_detail_id = options[:company_detail_id]
        ha.address1 = options[:address_line_1]
        ha.address2 = options[:address_line_2]
        ha.pincode_id = options[:pincode_id]
        ha.save!
        ha
      end

      def company_contact_details options
        cond = ContactDetail.new
        cond.company_detail_id = options[:company_detail_id]
        cond.email1 = options[:email1]
        cond.landline = options[:landline_no]
        cond.save!
        cond
      end

      def create_address_detail options
        st = State.find_or_create_by(name: options[:state])
        city = City.find_or_create_by(name: options[:city],state_id: st.id)
        pincode = Pincode.find_or_create_by(pincode: options[:pincode],city_id: city.id)
        pincode
      end

      def register options
        ApplicationRecord.connection.transaction do
          cd = create_company_details options
          options[:company_detail_id] = cd.id
          create_company_detail_user options
          company_contact_details options
          pincode = create_address_detail options
          options[:pincode_id] = pincode.id
          create_headquaters options
        end
      end
    end
  end
end
