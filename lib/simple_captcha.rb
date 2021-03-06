# encoding: utf-8

module SimpleCaptcha
  autoload :Utils,             'simple_captcha/utils'

  autoload :ImageHelpers,      'simple_captcha/image'
  autoload :ViewHelper,        'simple_captcha/view'
  autoload :ControllerHelpers, 'simple_captcha/controller'

  autoload :FormBuilder,       'simple_captcha/form_builder'
  autoload :CustomFormBuilder, 'simple_captcha/formtastic'


  autoload :Middleware,        'simple_captcha/middleware'

  mattr_accessor :image_size
  @@image_size = "100x28"

  mattr_accessor :length
  @@length = 5

  # 'embosed_silver',
  # 'simply_red',
  # 'simply_green',
  # 'simply_blue',
  # 'distorted_black',
  # 'all_black',
  # 'charcoal_grey',
  # 'almost_invisible'
  # 'random'
  mattr_accessor :image_style
  @@image_style = 'simply_blue'

  # 'low', 'medium', 'high', 'random'
  mattr_accessor :distortion
  @@distortion = 'low'

  # command path
  mattr_accessor :image_magick_path
  @@image_magick_path = ''

  # tmp directory
  mattr_accessor :tmp_path
  @@tmp_path = Dir::tmpdir

  # point size
  mattr_accessor :point_size
  @@point_size = 22

  # the expected captcha value for test
  mattr_accessor :test_captcha
  @@test_captcha = 'test'

  def self.add_image_style(name, params = [])
    SimpleCaptcha::ImageHelpers.image_styles.update(name.to_s => params)
  end

  def self.setup
    yield self
  end

  class << self
    def store
      @store || 'active_record'
    end

    def store=(type)
      @store = type
      if type == 'redis'
        instance_eval %q{
          mattr_accessor :redis, :expire
          @@redis = nil
          @@expire = 3600
        }
      end
    end
  end
end

require 'simple_captcha/engine' if defined?(Rails)
