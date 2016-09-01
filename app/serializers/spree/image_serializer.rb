module Spree
  class ImageSerializer < ActiveModel::Serializer

    attributes  :attachment_url

    def attachment_url
      object.attachment.url
    end
  end
end
