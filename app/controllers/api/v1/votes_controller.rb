# frozen_string_literal: true

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
        count = Hash.new(0)
        numbers.each {|number| count[number] += 1}
        most_frequent_numbers = count.sort_by { |k,v| v }.last

        return "The score is: #{most_frequent_numbers}"
      end
    end
  end
end
