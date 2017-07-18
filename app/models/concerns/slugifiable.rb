module Slugifiable

  module InstanceMethods

    def slugify(instance_variable)
      self.send("#{instance_variable}").downcase.gsub(" ", "-")
    end

  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find{|x| x.slug == slug}
    end
  end


end
