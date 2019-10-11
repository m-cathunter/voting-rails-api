module Api
  module V1
    class VotesController < ApplicationController
      def index
        voting = Voting.find(params[:voting_id])
        votes = voting.votes
        numbers = votes.map{ |vote| vote.number}
        score = score(numbers)
        render json: {status: 'SUCCESS', message: 'Loaded votes', data: [votes, score]}, status: :ok
      end

      def show
        votes = Vote.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Show vote', data: votes}, status: :ok
      end

      def create
        vote = Vote.new(vote_params)

        if vote.save
          render json: {status: 'SUCCESS', message: 'Saved vote', data: vote}, status: :ok
        else
          render json: {status: 'ERROR', message: 'Vote not saved',
            data: vote.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        vote = Vote.find(params[:id])
        vote.destroy
        render json: {status: 'SUCCESS', message: 'Deleted vote', data: vote}, status: :ok
      end

      private

      def vote_params
        params.permit(:name, :number, :voting_id)
      end

      def score(numbers)

        count = []
        output = []
        numbers.compact!
        unique = numbers.uniq
        j=0

        unique.each do |i|
            count[j] = numbers.count(i)
            j+=1
        end
        k=0
        count.each do |i|
            output[k] = unique[k] if i == count.max
            k+=1
        end

        return "The score is: #{output.compact.inspect}"
      end
    end
  end
end
