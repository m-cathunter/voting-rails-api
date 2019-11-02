module Api
  module V1
    class VotingsController < ApplicationController
      def index
        votings = Voting.all
        render json: {status: 'SUCCESS', message: 'Loaded voteings', data: votings}, status: :ok
      end

      def show
        voting = Voting.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded voting', data: voting}, status: :ok
      end

      def create
        voting = Voting.new(voting_params)

        if voting.save
          render json: {status: 'SUCCESS', message: 'Saved voting', data: voting}, status: :ok
        else
          render json: {status: 'ERROR', message: 'Voting not saved',
            data: voting.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        voting = Voting.find(params[:id])
        voting.destroy
        render json: {status: 'SUCCESS', message: 'Deleted voting', data: voting}, status: :ok
      end

      def update
        voting = Voting.find(params[:id])
        if voting.update_attributes(voting_params)
          render json: {status: 'SUCCESS', message: 'Updated voting', data: voting}, status: :ok
        else
          render json: {status: 'ERROR', message: 'Voting not updated',
            data: voting.errors}, status: :unprocessable_entity
        end
      end

      private

      def voting_params
        params.permit(:name, :description, :number_of_votes)
      end
    end
  end
end
