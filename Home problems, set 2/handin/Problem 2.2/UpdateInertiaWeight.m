function updatedInertiaWeight = UpdateInertiaWeight(inertiaWeight, beta, lowerBound)
    updatedInertiaWeight = max(inertiaWeight * beta, lowerBound);
end
