# Be sure to restart your server when you modify this file.

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self
    policy.font_src    :self, :data
    policy.img_src     :self, :data
    policy.object_src  :none
    policy.script_src  :self
    # unsafe_inline necessario: Font Awesome JS inietta un <style> nel DOM a runtime
    policy.style_src   :self, :unsafe_inline
    # wss: per Action Cable (Solid Cable)
    policy.connect_src :self, "wss:"
  end
end
