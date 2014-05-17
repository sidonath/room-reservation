class Team
  include Lotus::Entity

  def users
    @users ||= []
  end
end
