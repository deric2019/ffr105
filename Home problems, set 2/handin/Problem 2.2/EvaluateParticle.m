function score = EvaluateParticle(particle)
    x = particle(1);
    y = particle(2);
    score = EvaluateFunction(x, y);
end
