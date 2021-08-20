# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MetaTags::ViewHelper, 'displaying refresh' do
  it 'displays refresh when "refresh" is used' do
    subject.refresh(5)
    subject.display_meta_tags(site: 'someSite').tap do |meta|
      expect(meta).to have_tag('meta', with: { content: '5', 'http-equiv' => 'refresh' })
    end
  end

  it 'displays refresh when "set_meta_tags" used' do
    subject.set_meta_tags(refresh: 5)
    subject.display_meta_tags(site: 'someSite').tap do |meta|
      expect(meta).to have_tag('meta', with: { content: '5', 'http-equiv' => 'refresh' })
    end
  end

  it 'uses custom refresh if given' do
    subject.refresh("5;url=http://example.com/")
    subject.display_meta_tags(site: 'someSite').tap do |meta|
      expect(meta).to have_tag('meta', with: { content: '5;url=http://example.com/', 'http-equiv' => "refresh" })
    end
  end

  it 'displays nothing by default' do
    subject.display_meta_tags(site: 'someSite').tap do |meta|
      expect(meta).not_to have_tag('meta', with: { 'http-equiv' => "refresh" })
    end
  end
end
