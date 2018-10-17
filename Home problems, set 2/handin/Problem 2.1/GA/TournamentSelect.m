function iSelected = TournamentSelect(fitnessValues, tournamentSelectionParameter, tournamentSize)
    populationSize = length(fitnessValues);
    
    tournamentParticipants = zeros(1, tournamentSize);
    for i = 1:tournamentSize
        tournamentParticipants(i) = RandomIndex(populationSize);
    end
    
    sortedTournamentParticipants = SortByFitnessValue(tournamentParticipants, fitnessValues);
    
    selected = false;
    for i = 1:tournamentSize
        r = rand;
        if r < tournamentSelectionParameter
            iSelected = sortedTournamentParticipants(i);
            selected = true;
            break;
        end
    end
    
    if selected == false
        iSelected = sortedTournamentParticipants(end);
    end
end

function sortedTournamentParticipants = SortByFitnessValue(tournamentParticipants, fitnessValues)
    tournamentSize = length(tournamentParticipants);
    
    tournamentParticipantsFitnessValues = zeros(1, tournamentSize);
    for i = 1:tournamentSize
        iParticipant = tournamentParticipants(i);
        tournamentParticipantsFitnessValues(i) = fitnessValues(iParticipant);
    end
    
    [~, iSorted] = sort(tournamentParticipantsFitnessValues, 'descend');
    sortedTournamentParticipants = tournamentParticipants(iSorted);
end
