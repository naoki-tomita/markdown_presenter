require 'coderay'
module UploadFilesHelper
  def markdown_to_html(markdown)
    GitHub::Markdown.to_html(markdown, :gfm) do |code, lang|
      puts lang
      puts CodeRay::FileType.fetch(lang, :text)
      CodeRay.scan(code, CodeRay::FileType.fetch("hoge.#{lang}", :text)).div
    end
  end
end
