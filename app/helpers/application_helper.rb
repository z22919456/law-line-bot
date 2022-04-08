module ApplicationHelper
  def safe_liff_path(*args, **option)
    if ENV['LIFF_COMPACT'].present? && ENV['LIFF_TALL'].present? && ENV['LIFF_FULL'].present?
      return liff_path(*args,
                       **option)
    end

    root_url
  end
end
