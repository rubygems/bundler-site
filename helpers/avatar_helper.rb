module AvatarHelper
  def team_member(login, name)
    partial "partials/team_member", locals: {login: login, name: name}
  end
end