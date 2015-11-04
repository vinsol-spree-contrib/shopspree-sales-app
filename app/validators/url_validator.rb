class UrlValidator < ActiveModel::EachValidator

  REGEXP = {
    url: {
      universal:  /\Ahttp(s)?:\/\/[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,6}(\/.*)?\Z/i
    }
  }

  def validate_each(record, attribute, value)
    unless self.class.valid?(value, options)
      record.errors.add(attribute, options[:message] || :invalid)
    end
  end

  def self.valid?(value, options = {})
    value.match(regexp(options))
  end

  def self.regexp(options = {})
    options[:domain] ? REGEXP[:url][options[:domain]] : REGEXP[:url][:universal]
  end
end