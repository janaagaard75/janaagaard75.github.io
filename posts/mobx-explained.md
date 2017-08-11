# MobX Explained with an Example

We have a simpel class, `Circle`, that has two properties `radius` and `area`. `area` is a read only property, of curse directly dependent on the value of radius. We want a solution that only calculates the area once it's needed, and that caches that calculated value until a new radius is set.

## Simple Solution, Without MobX

```typescript
class Circle {
  constructor(radius: number) {
    this.setRadius(radius)
  }

  private radius: number
  private area: number | undefined
  
  public getRadius(): number {
    return this.radius
  }
  
  public setRadius(radius: number) {
    this.radius = radius
    this.area = undefined
  }
  
  public getArea(): number {
    if (this.area == undefined) {
      this.area = 2 * Math.PI * this.radius * this.radius
    }

    return this.area
  }
}
```

## With Getters and Setters

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
class Circle {
  constructor(radius: number) {
    this.setRadius(radius)
  }
  
  private radius: number
  
  public getRadius(): number {
    return this.radius
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
