require File.expand_path(File.join(File.dirname(__FILE__), '../config', 'environment'))

product_property_type = Spree::ProductPropertyType.where(name: 'General Settings').first_or_create

Spree::ProductProperty.update_all(type_id: product_property_type.id)