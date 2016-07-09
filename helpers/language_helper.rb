module LanguageHelper
  LOCALES_DIR = 'locales'.freeze
  LOCALIZABLE_DIR = 'source/localizable/'.freeze

  def current_page_languages_select
    current_page_languages&.map { |k, v| [v, k] } || [%w(English en)]
  end

  def current_page_languages
    return nil unless current_page_language
    path = current_path =~ /\A\w{2}\// ? current_page.path[3..-1] : current_page.path

    current_page.path =~ /\.\w{2}\.html/ ? languages_per_filename(path) :
      languages_from_locales(path)
  end

  def current_page_language
    current_page.metadata.dig(:options, :locale)
  end

  private

  def languages_from_locales(path)
    dirname = File.dirname(path)
    filename = File.basename(path, '.*')

    return unless Dir["#{LOCALIZABLE_DIR}#{dirname}/#{filename}*"]

    languages = Dir[File.join(LOCALES_DIR, '*.yml')].map do |file|
      File.basename(file).gsub('.yml', '')
    end

    translated = languages.map { |lang| [lang, t("languages.#{lang}")] }.flatten
    Hash[*translated]
  end

  def languages_per_filename(path)
    dirname = File.dirname(path)
    filename = File.basename(path, '.*')

    matched = Dir["#{LOCALIZABLE_DIR}#{dirname}/*"].map do |f|
      File.basename(f, '.*').match(/\A#{Regexp.escape(filename)}\.(\w{2})\./)
    end.compact

    translated = matched.map { |match| [match[1] => t("languages.#{match[1]}")] }
    Hash[*translated]
  end
end
