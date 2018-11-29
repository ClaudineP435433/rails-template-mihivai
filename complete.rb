def add_gems
  <<-RUBY
  source 'https://rubygems.org'
  ruby '#{RUBY_VERSION}'

  #{"gem 'bootsnap', require: false" if Rails.version >= "5.2"}
  gem 'devise'
  gem 'jbuilder', '~> 2.0'
  gem 'pg', '~> 0.21'
  gem 'puma'
  gem 'rails', '#{Rails.version}'
  gem 'redis'
  gem 'jquery-rails'
  gem 'bootstrap', '~> 4.1.1'
  gem 'autoprefixer-rails'
  gem 'font-awesome-sass', '~> 5.0.9'
  gem 'sassc-rails'
  gem 'simple_form'
  gem 'uglifier'
  gem 'webpacker'
  gem 'slim'

  group :development do
    gem 'rails-erd'
    gem 'web-console', '>= 3.3.0'
  end

  group :development, :test do
    gem 'pry-byebug'
    gem 'pry-rails'
    gem 'listen', '~> 3.0.5'
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.0'
    gem 'dotenv-rails'
    gem 'spring-watcher-listen', '~> 2.0.0'
  end
  RUBY
end

def add_users
end

def add_layout
  <<-HTML
  <!DOCTYPE html>
    <html>
      <head>
        <%= render "layouts/google_analytics" %>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title><%= yield(:title) || "yourdomain" %></title>
        <%= csrf_meta_tags %>
        <%= action_cable_meta_tag %>
        <%= stylesheet_link_tag 'application', media: 'all' %>
        <%#= stylesheet_pack_tag 'application', media: 'all' %> <!-- Uncomment if you import CSS in app/javascript/packs/application.js -->
      </head>
      <body>
        <%= render 'shared/navbar' %>
        <%= render 'shared/flashes' %>
        <%= yield %>
        <%= render 'shared/footer' %>

        <script type="application/ld+json">
          {
            "@context": "http://schema.org",
            "@type": "Organization",
            "name": "yourdomain",
            "url": "https://www.yourdomain.com/",
            "logo": "",
            "contactPoint": [{
              "@type": "ContactPoint",
              "url": "https://www.yourdomain.com",
              "email": "contact@yourdomain.com",
              "telephone": "+33-30000000",
              "contactType": "customer service"
            }],
            "image": "",
            "description": ""
          }
        </script>
        <%= javascript_include_tag 'application' %>
        <%= javascript_pack_tag 'application' %>
      </body>
    </html>
    HTML
  end

def add_flash
  <<-HTML
    <% if notice %>
      <div class="alert alert-info alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <%= notice %>
      </div>
    <% end %>
    <% if alert %>
      <div class="alert alert-warning alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <%= alert %>
      </div>
    <% end %>
  HTML
end

def add_google_analytics
  <<-HTML
    <% if Rails.env == "production"  %>
      <!-- Global site tag (gtag.js) - Google Analytics -->
      <script async src="https://www.googletagmanager.com/gtag/js?id=<%= ENV['GOOGLE_ANALYTICS_KEY'] %>"></script>
      <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        gtag('config', "<%= ENV['GOOGLE_ANALYTICS_KEY'] %>");
      </script>
    <% end %>
  HTML
end

def update_error_page(var)
  <<-HTML
    <!DOCTYPE html>
    <html>
    <head>
      <title><%= "Yourdomain - Error #{var}" %></title>
      <meta name="viewport" content="width=device-width,initial-scale=1">
      <meta charset="UTF-8">
      <style>
        body {
            background-color: white;
            color: #2E2F30;
            text-align: center;
            font-family: arial, sans-serif;
          }

          .banner-logo img {
            max-width: 90%;
          }

          .container {
            margin: 100px;
          }
          .head-line {
            font-size: 16px;
          }
          .button-green a {
            text-decoration: none;
            padding: 10px 41px;
            color: white;
            background-color: #4cceb1;
            font-weight: lighter;
          }
         .button-green a:hover {
            text-decoration: none;
            color: grey;
          }
          .rails-default-error-page {
            width: 100vw;
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
          }
        </style>
      </head>

      <body class="rails-default-error-page">
        <!-- This file lives in public/500.html -->
          <div class="banner-logo">
            <img src="banner.png" alt="banner">
          </div>
          <div class="container">
            <div class="head-line">
              <b>Erreur <%= var %></b>
            </div>
            <div class="subheader primary-text-color">

              Désolé une erreur est revenue. <br> Veuillez nous excuser pour la gêne occasionée.
            </div>
          </div>
          <div class="button-green">
            <a class="button-green" href="/#">Retour sur le site</a>
          </div>
      </body>
    </html>
  HTML
end

def add_navbar
  <<-HTML
    <div class="navbar-mihivai d-flex align-items-center justify-content-between">
      <!-- Logo -->
      <%= link_to (image_tag "logo.png", height: 50), root_path %>

      <!-- MD & LG Navigation -->
      <div class="navbar-mihivai-right d-none d-lg-block ">
        <div class="d-flex align-items-center justify-content-between">
          <%= link_to "Notre Activité", "/" %>
          <%= link_to "Nos Services", "/" %>
          <%= link_to "Contact", "/" %>
          <% if user_signed_in? %>
            <%= link_to t(".sign_out", default: "Log out"), destroy_user_session_path, method: :delete %>
          <% else %>
            <%= link_to t(".sign_in", default: "Login"), new_user_session_path %>
          <% end %>
        </div>
      </div>

      <!-- Dropdown list appearing on mobile only -->
      <div class="navbar-dropdown d-lg-none">
        <input id="toggle" type="checkbox"/>
        <label class="hamburger" for="toggle">
          <div class="top"></div>
          <div class="meat"></div>
          <div class="bottom"></div>
        </label>

        <div class="nav">
          <div class="nav-wrapper w-100">
            <nav class="d-flex w-100">
              <%= link_to "Informations", "/", class: "navbar-link" %>
              <% if user_signed_in? %>
                <%= link_to "Se Déconnecter", destroy_user_session_path, class: "navbar-link", method: :delete %>
              <% else %>
                <%= link_to "Créer un Compte", new_user_registration_path, class: "navbar-link" %>
                <%= link_to "Se Connecter", new_user_session_path,  class: "navbar-link" %>
              <% end %>
            </nav>
          </div>
        </div>
      </div>
    </div>
  HTML
end

run 'pgrep spring | xargs kill -9'

# GEMFILE
########################################
run 'rm Gemfile'
file 'Gemfile',
  add_gems

# Ruby version
########################################
file '.ruby-version', RUBY_VERSION

# Procfile
########################################
file 'Procfile', <<-YAML
web: bundle exec puma -C config/puma.rb
YAML

# Spring conf file
########################################
# inject_into_file 'config/spring.rb', before: ').each { |path| Spring.watch(path) }' do
#   '  config/application.yml\n'
# end

# Assets
########################################
run 'rm -rf app/assets/stylesheets'
run 'rm -rf vendor'
run 'curl -L https://github.com/lewagon/stylesheets/archive/master.zip > stylesheets.zip'
run 'unzip stylesheets.zip -d app/assets && rm stylesheets.zip && mv app/assets/rails-stylesheets-master app/assets/stylesheets'
inject_into_file 'app/assets/stylesheets/config/_bootstrap_variables.scss', before: '// Override other variables below!' do
"
// Patch to make simple_form compatible with bootstrap 3
.invalid-feedback {
  display: none;
  width: 100%;
  margin-top: 0.25rem;
  font-size: 80%;
  color: $red;
}
.was-validated .form-control:invalid,
.form-control.is-invalid,
.was-validated .custom-select:invalid,
.custom-select.is-invalid {
  border-color: $red;
}

.was-validated .form-control:invalid ~ .invalid-feedback,
.was-validated .form-control:invalid ~ .invalid-tooltip,
.form-control.is-invalid ~ .invalid-feedback,
.form-control.is-invalid ~ .invalid-tooltip,
.was-validated .custom-select:invalid ~ .invalid-feedback,
.was-validated .custom-select:invalid ~ .invalid-tooltip,
.custom-select.is-invalid ~ .invalid-feedback,
.custom-select.is-invalid ~ .invalid-tooltip {
  display: block;
}
"
end

run 'grep -v px app/assets/stylesheets/config/_bootstrap_variables.scss > tmp.txt && mv -f tmp.txt app/assets/stylesheets/config/_bootstrap_variables.scss'
run "awk '!/bootstrap-sprockets/' app/assets/stylesheets/application.scss > tmp.txt && mv -f tmp.txt app/assets/stylesheets/application.scss"
run "awk '!/navbar/' app/assets/stylesheets/components/_index.scss > tmp.txt && mv -f tmp.txt app/assets/stylesheets/components/_index.scss"

run 'cat navbar-mihivai.sccs > app/assets/stylesheets/components/_navbar.scss'

run 'rm app/assets/javascripts/application.js'
file 'app/assets/javascripts/application.js', <<-JS
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require_tree .
JS

# Dev environment
########################################
gsub_file('config/environments/development.rb', /config\.assets\.debug.*/, 'config.assets.debug = false')

# Layout
########################################
file 'app/views/layouts/_google_analytics.html.erb',
  add_google_analytics

run 'rm app/views/layouts/application.html.erb'
file 'app/views/layouts/application.html.erb',
  add_layout

file 'app/views/shared/_flashes.html.erb',
  add_flash

run 'rm public/500.html.erb'
file 'public/500.html.erb',
  update_error_page(500)

run 'rm public/404.html.erb'
file 'public/404.html.erb',
  update_error_page(404)

run 'rm public/422.html.erb'
file 'public/422.html.erb',
  update_error_page(422)


file 'app/views/shared/_navbar.html.erb',
  add_navbar

run 'curl -L https://raw.githubusercontent.com/Joz84/rails-templates/master/logo.png > app/assets/images/logo.png'


# README
########################################
markdown_file_content = <<-MARKDOWN
Rails app generated with MihiVai template.
MARKDOWN
file 'README.md', markdown_file_content, force: true

# Generators
########################################
generators = <<-RUBY
config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework  :test_unit, fixture: false
    end
RUBY

environment generators

########################################
# AFTER BUNDLE
########################################
after_bundle do
  # Generators: db + simple form + pages controller
  ########################################
  rails_command 'db:drop db:create db:migrate'
  generate('simple_form:install', '--bootstrap')
  generate(:controller, 'pages', 'home', '--skip-routes', '--no-test-framework')

  # Routes
  ########################################
  route "root to: 'pages#home'"

  # Git ignore
  ########################################
  run 'rm .gitignore'
  file '.gitignore', <<-TXT
  .bundle
  log/*.log
  tmp/**/*
  tmp/*
  !log/.keep
  !tmp/.keep
  *.swp
  .DS_Store
  public/assets
  public/packs
  public/packs-test
  node_modules
  yarn-error.log
  .byebug_history
  .env*
  TXT


  # Devise install + user
  ########################################
  generate('devise:install')
  generate('devise', 'User')

  # App controller
  ########################################
  run 'rm app/controllers/application_controller.rb'
  file 'app/controllers/application_controller.rb', <<-RUBY
    class ApplicationController < ActionController::Base
      protect_from_forgery with: :exception
      before_action :authenticate_user!
    end
  RUBY

  # migrate + devise views
  ########################################
  rails_command 'db:migrate'
  generate('devise:views')

  # Pages Controller
  ########################################
  run 'rm app/controllers/pages_controller.rb'
  file 'app/controllers/pages_controller.rb', <<-RUBY
  class PagesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:home]

    def home
    end
  end
  RUBY

  # Environments
  ########################################
  environment 'config.action_mailer.default_url_options = { host: "localhost", port: 3000 }', env: 'development'
  environment 'config.action_mailer.default_url_options = { host: "http://TODO_PUT_YOUR_DOMAIN_HERE" }', env: 'production'

# Webpacker / Yarn
  ########################################
  run 'rm app/javascript/packs/application.js'
  run 'yarn add jquery bootstrap@3'
  file 'app/javascript/packs/application.js', <<-JS
    import "bootstrap";
  JS

    inject_into_file 'config/webpack/environment.js', before: 'module.exports' do
    <<-JS
    // Bootstrap 3 has a dependency over jQuery:
    const webpack = require('webpack')
    environment.plugins.prepend('Provide',
      new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery'
      })
    )
    JS
  end

  # Dotenv
  ########################################
  run 'touch .env'

  # Rubocop
  ########################################
  run 'curl -L https://raw.githubusercontent.com/lewagon/rails-templates/master/.rubocop.yml > .rubocop.yml'

  # Git
  ########################################
  git :init
  git add: '.'
  git commit: "-m 'Initial commit of Mihivai App'"
end
