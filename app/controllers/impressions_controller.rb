class ImpressionsController < ApplicationController

    def new
        
    end

    def add_impression_field
        @impressions = Impression.new
        respond_to do |format|
            format.html
            format.js
        end
       
    end

    def create

    end

    def edit
        
    end

    def show
        
    end

    def update
        
    end

    def destroy
        
    end
end
