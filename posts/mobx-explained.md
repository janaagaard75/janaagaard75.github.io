# MobX Explained

## Native Circle Class

We have a simpel class, `Circle`, that has two properties `radius` and `area`. `area` is a read only property, of curse directly dependent on the value of radius. (We assume that you will won't assign a negative number to `radius`.)

```typescript
class Circle {
  constructor(radius: number) {
    this.radius = radius
  }

  public radius: number
  
  public get area(): number {
    return 2 * Math.PI * this.radius * this.radius
  }
}
```

## Simple Solution, Without MobX

Calculating the area is pretty simply and thus fast, but let's assume that the calculations were complicated, so we want to add these two features to our class:

* We want `area` to be _lazy_, that is we only want to calculate the it, if we actually need it.
* We want to _cache_ the value, so that we don't have to recalculate it, should we access it more than once.

```typescript
class Circle {
  constructor(radius: number) {
    this.radius = radius
  }

  private _radius: number
  private _area: number | undefined
  
  public get radius(): number {
    return this._radius
  }
  
  public set radius(radius: number) {
    this._radius = radius
    this._area = undefined
  }
  
  public get area(): number {
    if (this._area == undefined) {
      this._area = 2 * Math.PI * this._radius * this._radius
    }

    return this._area
  }
}
```

## Without MobX, But a More MobX'y Solution

```typescript
let accessedObservables: Array<string>
let computedValues = {}
let usedInComputedValues = {}

class Circle {
  constructor(radius: number) {
    this.setRadius(radius)
  }
  
  private _radius: number

  public get radius(): number {
    accessedObservables.push('radius')
    return this._radius
  }
  
  public set radius(radius: number) {
    this._radius = radius
    
    if (usedInComputedValues[accessedObservable] !== undefined) {
      usedInComputedValues[accessedObservable].forEach(computedValue =>
        computedValues[computedValue] === undefined
      )
    }
  }
  
  public get area(): number {
    if (this.computedValues['area'] === undefined) {
      accessedObservables = []

      computedValues['area'] = 2 * Math.PI * this.radius * this.radius

      if (usedInComputedValues[accessedObservable] === undefined) {
        usedInComputedValues[accessedObservable] = []
      }

      accessedObservables.forEach(accessedObservable => {
        usedInComputedValues[accessedObservable].push('area')
      })
    }
    
    return computedValues['area']
  }
}
```

## With MobX

Marking `radius` as an `observable` means that the property is wrapped in a getter and a setter, so now MobX knows when the value is read and set.

Marking `area` as a `computed` means that 1) when the value is calculated, MobX makes a not of any observable properties used to calculate the value, and 2) the calculated value is memoised cached until one of the observables used to calculated the value has changed.

```typescript
class Circle {
  constructor(radius: number) {
    this.radius = radius
  }
  
  @observable private radius: number
  
  @computed
  public get area(): number {
    return 2 * Math.PI * this.radius * this.radius
  }
}
