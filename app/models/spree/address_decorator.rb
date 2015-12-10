Spree::Address.class_eval do

  validators.each do |a|
    a.attributes.reject! {|field| field.to_s =~ /firstname|lastname/ } if a.kind == :presence
  end

end
