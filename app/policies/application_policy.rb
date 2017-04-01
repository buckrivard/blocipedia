class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    scope
  end

  def show?
    if user.role == 'admin'
      true
    elsif user.role == 'premium'
      true if record.user_id == user.id || !(record.private?) || record.collaborators.include?(user)
    else
      true if !(record.private?) || record.collaborators.include?(user)
    end
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? || record.user_id == user.id
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !(wiki.private?) || wiki.user_id == user.id || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !(wiki.private?) || wiki.collaborators.
            wikis << wiki
          end
        end
      end
      wikis
    end
    
  end

end
