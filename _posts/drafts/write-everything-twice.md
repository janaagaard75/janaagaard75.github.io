# Write everything twice

There is a principle in programming called DRY that stands for Don't Repeat Yourself. It means that you should extract duplicated code into functions, components and classes, so that everything is written only once. The main benefit is if you need to change something, like fix a bug, you only have to make the change in one place, and that change will be reflected everywhere. Unless taken to the extreme, DRY is generally a good principle.

On the other hand there is also a quote from Sandi Metz that says "Duplication is far cheaper than the wrong abstraction." This means that you should be careful when extracting code, because if you extract the wrong code, the abstraction will work against you when you have to make changes, and you will end up with more complicated - and thus costlier - maintenance job, that if you had just duplicated the code in the first place.

This leads us WET, Write Everything Twice. In other to ensure that you make the correct extractions of the code, start by duplicating. You don't have to literally copy paste another component, but if you have to make a variation of a component consider starting out by creating a new one from scratch. Almost as if the first one didn't exist. This way you ensure that the new component doesn't carry any of the legacy from the first one, and you ensure that the first component isn't contaminated by the new requirements. Once you're done, take a look at the two components and then figure out if it's worth to combine them or extract some common logic or a sub component.

