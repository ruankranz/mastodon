# frozen_string_literal: true
class DomainAllow < ApplicationRecord
  include DomainNormalizable

  validates :domain, presence: true, uniqueness: true

  class << self
    def allowed?(domain)
      return false if domain.blank?

      uri = Addressable::URI.new.tap { |u| u.host = domain.gsub(/[\/]/, '') }

      where(domain: uri.normalized_host).exists?
    end
  end
end
