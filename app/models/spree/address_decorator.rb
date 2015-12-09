Spree::Address.class_eval do

  validators.each do |a|
    a.attributes.reject! {|field| field.to_s =~ /firstname|lastname/ } if a.kind == :presence
  end

  attr_reader :street

  after_validation :abc, if: :street

  def street=(street_name)
    @street = street_name
    self.address1 = street_name
  end

  def state_code=(state_code)
    state = State.find_by(abbr: state_code)
    if state
      self.state_name = state.name
      self.state_id = state.id
    end
  end

end
