//
//  ContentView.swift
//  Planets3DSceneKit
//
//  Created by Ginger on 06/12/2020.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var models = [
        Model(id: 0, name: "Earth", modelName: "Earth.usdz", details: "Earth is the third planet from the Sun and the only astronomical object known to harbor life. About 29% of Earth's surface is land consisting of continents and islands. The remaining 71% is covered with water, mostly by oceans but also lakes, rivers and other fresh water, which together constitute the hydrosphere. Much of Earth's polar regions are covered in ice. Earth's outer layer is divided into several rigid tectonic plates that migrate across the surface over many millions of years. Earth's interior remains active with a solid iron inner core, a liquid outer core that generates Earth's magnetic field, and a convecting mantle that drives plate tectonics."),
        
        Model(id: 1, name: "Jupiter", modelName: "Jupiter.usdz", details: "Jupiter is the fifth planet from the Sun and the largest in the Solar System. It is a gas giant with a mass one-thousandth that of the Sun, but two-and-a-half times that of all the other planets in the Solar System combined. Jupiter is one of the brightest objects visible to the naked eye in the night sky, and has been known to ancient civilizations since before recorded history. It is named after the Roman god Jupiter. When viewed from Earth, Jupiter can be bright enough for its reflected light to cast visible shadows, and is on average the third-brightest natural object in the night sky after the Moon and Venus."),
        
        Model(id: 2, name: "Mars", modelName: "Mars.usdz", details: "Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System, being larger than only Mercury. In English, Mars carries the name of the Roman god of war and is often referred to as the Red Planet. The latter refers to the effect of the iron oxide prevalent on Mars's surface, which gives it a reddish appearance distinctive among the astronomical bodies visible to the naked eye. Mars is a terrestrial planet with a thin atmosphere, with surface features reminiscent of the impact craters of the Moon and the valleys, deserts and polar ice caps of Earth."),
        
        Model(id: 3, name: "Pluto", modelName: "Pluto.usdz", details: "Pluto (minor planet designation: 134340 Pluto) is a dwarf planet in the Kuiper belt, a ring of bodies beyond the orbit of Neptune. It was the first and the largest Kuiper belt object to be discovered. After Pluto was discovered in 1930 it was declared to be the ninth planet from the Sun. Beginning in the 1990s, its status as a planet was questioned following the discovery of several objects of similar size in the Kuiper belt, including the dwarf planet Eris. This led the International Astronomical Union (IAU) in 2006 to formally define the term planet — excluding Pluto and reclassifying it as a dwarf planet."),
        
        Model(id: 4, name: "Venus", modelName: "Venus.usdz", details: "Venus is the second planet from the Sun. It is named after the Roman goddess of love and beauty. As the second-brightest natural object in Earth's night sky after the Moon, Venus can cast shadows and can be, on rare occasion, visible to the naked eye in broad daylight. Venus lies within Earth's orbit, and so never appears to venture far from the Sun, either setting in the west just after dusk or rising in the east a bit before dawn. Venus orbits the Sun every 224.7 Earth days. With a rotation period of 243 Earth days, it takes longer to rotate about its axis than any other planet in the Solar System by far, and does so in the opposite direction to all but Uranus (meaning the Sun rises in the west and sets in the east). Venus does not have any moons, a distinction it shares only with Mercury among the planets in the Solar System.")
    ]
    
    @State var index = 0
    
    var body: some View {
        VStack {
            // Going to use SceneKit SceneView
            
            // Default first object: Earth
            
            // SceneView has a default Camera View
            SceneView(scene: SCNScene(named: models[index].modelName), options: [.allowsCameraControl, .autoenablesDefaultLighting])
            // for user action
            // setting customer frame
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
            
            ZStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            if index > 0 {
                                index -= 1
                            }
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 35, weight: .bold))
                            .opacity(index == 0 ? 0.3 : 1)
                    }
                    .disabled(index == 0)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        withAnimation {
                            if index < models.count {
                                index += 1
                            }
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 35, weight: .bold))
                        // disabling button when no other data
                            .opacity(index == models.count - 1 ? 0.3 : 1)
                    }
                    .disabled(index == models.count - 1)
                }
                
                Text(models[index].name)
                    .font(.system(size: 45, weight: .bold))
            }
            .foregroundColor(.black)
            .padding(.horizontal)
            .padding(.vertical, 30)
            
            VStack(alignment: .leading, spacing: 15, content: {
                Text("About")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(models[index].details)
            })
            .padding(.horizontal)
            
            Spacer(minLength: 0)
        }
    }
}

struct Model: Identifiable {
    var id: Int
    var name: String
    var modelName: String
    var details: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
