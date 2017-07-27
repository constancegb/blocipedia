class WikiPolicy < ApplicationPolicy
   attr_reader :user, :wiki

   def initialize(user, wiki)
     @user = user
     @wiki = wiki
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
         wikis = scope.all # if user is admin, show all the wikis
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki.private == false || wiki.user == user || wiki.collaborators.include?(user)
             wikis << wiki # if user premium, only show public wikis, or private wikis they created, or private wikis they are collaborator on
           end
         end
       else # standard user
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if wiki.private == false || wiki.collaborators.include?(user)
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
           end
         end
       end
       wikis # return the wikis array we've built up
     end
   end

end
