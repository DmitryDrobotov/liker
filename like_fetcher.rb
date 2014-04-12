require 'rubygems'
require 'json'
require 'pry'
require 'uri'
require 'open-uri'
require 'net/http'
require 'cgi'

class LikeFetcher

  attr_accessor :access_token, :user_id, :page_id

  def initialize(access_token, user_id, page_id)
    @access_token = access_token
    @user_id = user_id
    @page_id = page_id
  end

  def liked?
    json['data'].any?
  end

  protected

  def json
    uri = URI.parse("https://graph.facebook.com/#{@user_id}/likes/#{@page_id}")
    params = { access_token: @access_token }
    uri.query = URI.encode_www_form( params )
    @json ||= JSON.parse(uri.open.read)
  end
  
end