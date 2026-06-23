# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

def origin_from_master_bundle(entry)
  master_bundle = entry['MasterBundle'] || entry['masterBundle'] || entry['master_bundle']

  case master_bundle.to_s.strip.downcase
  when 'california2'
    'california-2'
  when 'morefarming_core'
    'more-farming-mod'
  when 'core'
    'vanilla'
  else
    nil
  end
end

def enrich_shop_entries(entries, category, base_uri)
  return unless entries.is_a?(Array)

  entries.each do |entry|
    next unless entry.is_a?(Hash)

    entry['iconUrl'] = nil
    entry['assetType'] = nil
    entry['url'] = nil

    entry_id = entry['ID'] || entry['id']
    next if entry_id.nil? || entry_id.to_s.strip.empty?

    origin = origin_from_master_bundle(entry)
    next if origin.nil?

    params = {
      'query' => entry_id.to_s,
      'origin' => origin,
      'category' => category,
      'maxResults' => '2'
    }

    request_uri = base_uri.dup
    request_uri.query = URI.encode_www_form(params)

    begin
      response = Net::HTTP.start(
        request_uri.host,
        request_uri.port,
        use_ssl: request_uri.scheme == 'https',
        open_timeout: 5,
        read_timeout: 10
      ) do |http|
        req = Net::HTTP::Get.new(request_uri)
        req['User-Agent'] = 'Jekyll shop_prices_enricher'
        http.request(req)
      end

      next unless response.is_a?(Net::HTTPSuccess)

      result = JSON.parse(response.body)
      next unless result.is_a?(Array) && !result.empty?

      api_entry = result.find do |candidate|
        candidate.is_a?(Hash) && candidate['category'].to_s.casecmp(category).zero?
      end

      next unless api_entry

      entry['iconUrl'] = api_entry['iconUrl'] if api_entry.key?('iconUrl')
      entry['assetType'] = api_entry['assetType'] if api_entry.key?('assetType')
      entry['url'] = api_entry['url'] if api_entry.key?('url')
    rescue StandardError => e
      Jekyll.logger.warn('shop_prices_enricher:', "Failed #{category.downcase} #{entry_id}: #{e.message}")
    end
  end
end

Jekyll::Hooks.register :site, :post_read do |site|
  data = site.data['shop_prices']
  next unless data.is_a?(Hash)

  items = data['Items'] || data['items']
  vehicles = data['Vehicles'] || data['vehicles']

  base_uri = URI('https://restoremonarchy.com/browser/search')

  enrich_shop_entries(items, 'Item', base_uri)
  enrich_shop_entries(vehicles, 'Vehicle', base_uri)
end