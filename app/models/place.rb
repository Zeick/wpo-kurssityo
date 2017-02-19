class Place < OpenStruct
    def self.rendered_fields
#        [:id, :name, :status, :street, :city, :zip, :country, :overall]
        [:name, :status, :street, :city, :zip, :country, :overall]
    end

#    def googlemap
#        return blogmap gsub("http", "https") if Rails.env.production?
#        blogmap
#    end
end
