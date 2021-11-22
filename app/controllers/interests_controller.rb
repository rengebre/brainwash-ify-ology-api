class InterestsController < ApplicationController
    def index
        @interests = Interest.all
        render :json => @interests
    end
end
