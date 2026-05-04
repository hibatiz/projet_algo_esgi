import numpy as np
from sklearn.linear_model import LinearRegression

def test_environnement_ml():
    print("\n" + "="*40)
    print("TEST DE L'ENVIRONNEMENT MACHINE LEARNING")
    print("="*40)
    
    # Données simples : [Heures de révision] -> [Note]
    X = np.array([[1], [2], [3], [4], [5]])
    y = np.array([8, 10, 12, 14, 16])
    
    # Entraînement d'un modèle rapide
    modele = LinearRegression()
    modele.fit(X, y)
    
    # Test de prédiction
    test_h = 6
    pred = modele.predict([[test_h]])
    
    print(f"Statut : Bibliothèques NumPy et Scikit-Learn opérationnelles.")
    print(f"Prédiction : Pour {test_h}h de révision, note estimée : {pred[0]:.1f}/20")
    print("="*40 + "\n")

if __name__ == "__main__":
    test_environnement_ml()