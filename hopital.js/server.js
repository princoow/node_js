const express = require('express');
const mysql = require('mysql2');
const path = require('path');
const bcrypt = require('bcrypt'); // Pour le hachage des mots de passe

const app = express();
const port = 3000;

app.use(express.static('public'));
app.use(express.json()); // Pour accepter les requêtes JSON (pour POST)

const connection = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: null,
  database: 'hopital',
  port: 3308
});

// Tester la connexion
connection.connect((err) => {
  if (err) {
    console.error('Erreur de connexion à la base de données: ' + err.stack);
    return;
  }
  console.log('Connecté à la base de données avec l\'ID ' + connection.threadId);
});

// Route pour rediriger vers la page d'accueil
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'connexion.html')); // Remplace 'index.html' par la page d'accueil
});

// Route pour créer un utilisateur
app.post('/api/user', (req, res) => {
  const { nom, prenom, adresse, telephone, email, mot_de_passe, statut } = req.body;
  
  // Vérifier si l'email existe déjà
  connection.query('SELECT * FROM users WHERE email = ?', [email], (err, results) => {
    if (err) {
      console.error('Erreur lors de la vérification de l\'email :', err);
      return res.status(500).json({ message: 'Erreur serveur' });
    }

    if (results.length > 0) {
      return res.status(400).json({ message: 'Email déjà utilisé' });
    }

    // Hashing du mot de passe avant l'insertion
    bcrypt.hash(mot_de_passe, 10, (err, hashedPassword) => {
      if (err) {
        console.error('Erreur lors du hachage du mot de passe:', err);
        return res.status(500).json({ message: 'Erreur serveur' });
      }

      // Insérer l'utilisateur dans la base de données
      const query = 'INSERT INTO users (nom, prenom, adresse, telephone, email, mot_de_passe, statut) VALUES (?, ?, ?, ?, ?, ?, ?)';
      connection.query(query, [nom, prenom, adresse, telephone, email, hashedPassword, statut], (err, result) => {
        if (err) {
          console.error('Erreur lors de l\'insertion :', err);
          return res.status(500).json({ message: 'Erreur serveur' });
        }
        res.status(200).json({ message: 'Utilisateur créé avec succès' });
      });
    });
  });
});

// Route pour lire les utilisateurs (tous)
app.get('/api/users', (req, res) => {
  connection.query('SELECT * FROM users', (err, results) => {
    if (err) {
      console.error('Erreur lors de la récupération des utilisateurs :', err);
      return res.status(500).json({ message: 'Erreur serveur' });
    }
    res.status(200).json(results);
  });
});

// Route pour mettre à jour un utilisateur
app.put('/api/user/:id_users', (req, res) => {
  const { id_users } = req.params;
  const { nom, prenom, adresse, telephone, email, mot_de_passe, statut } = req.body;

  // Hashing du mot de passe avant la mise à jour
  bcrypt.hash(mot_de_passe, 10, (err, hashedPassword) => {
    if (err) {
      console.error('Erreur lors du hachage du mot de passe:', err);
      return res.status(500).json({ message: 'Erreur serveur' });
    }

    const query = 'UPDATE users SET nom = ?, prenom = ?, adresse = ?, telephone = ?, email = ?, mot_de_passe = ?, statut = ? WHERE id_users = ?';
    
    connection.query(query, [nom, prenom, adresse, telephone, email, hashedPassword, statut, id_users], (err, result) => {
      if (err) {
        console.error('Erreur lors de la mise à jour :', err);
        return res.status(500).json({ message: 'Erreur serveur' });
      }
      res.status(200).json({ message: 'Utilisateur mis à jour avec succès' });
    });
  });
});

// Route pour supprimer un utilisateur
app.delete('/api/user/:id_users', (req, res) => {
  const { id_users } = req.params;
  
  const query = 'DELETE FROM users WHERE id_users = ?';
  
  connection.query(query, [id_users], (err, result) => {
    if (err) {
      console.error('Erreur lors de la suppression :', err);
      return res.status(500).json({ message: 'Erreur serveur' });
    }
    res.status(200).json({ message: 'Utilisateur supprimé avec succès' });
  });
});

// Route pour ajouter un rendez-vous
app.post('/api/appointments', (req, res) => {
    const { name, prenom, email, phone, date, specialty } = req.body;

    // Vérifier si tous les champs nécessaires sont présents
    if (!name || !prenom || !email || !phone || !date || !specialty) {
        return res.status(400).json({
            success: false,
            message: "Données manquantes. Veuillez remplir tous les champs."
        });
    }

    // Insérer le rendez-vous dans la base de données
    const query = 'INSERT INTO appointments (name, prenom, email, phone, date, specialty) VALUES (?, ?, ?, ?, ?, ?)';
    
    connection.query(query, [name, prenom, email, phone, date, specialty], (err, result) => {
        if (err) {
            console.error('Erreur lors de l\'insertion du rendez-vous :', err);
            return res.status(500).json({
                success: false,
                message: 'Erreur serveur. Impossible de prendre le rendez-vous.'
            });
        }

        // Si l'insertion réussit, renvoyer un message de succès
        res.status(200).json({
            success: true,
            message: 'Rendez-vous pris avec succès'
        });
    });
});

// Route pour afficher la page de confirmation
app.get('/confirmation.html', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'confirmation.html'));
});

// Route de connexion
app.post('/api/login', (req, res) => {
  const { email, mot_de_passe } = req.body;

  // Vérifier si l'utilisateur existe
  connection.query('SELECT * FROM users WHERE email = ?', [email], (err, results) => {
    if (err) {
      console.error('Erreur lors de la vérification de l\'email :', err);
      return res.status(500).json({ message: 'Erreur serveur' });
    }

    if (results.length === 0) {
      return res.status(400).json({ message: 'Email ou mot de passe incorrect' });
    }

    const user = results[0];

    // Vérifier le mot de passe
    bcrypt.compare(mot_de_passe, user.mot_de_passe, (err, isMatch) => {
      if (err) {
        console.error('Erreur lors de la vérification du mot de passe :', err);
        return res.status(500).json({ message: 'Erreur serveur' });
      }

      if (!isMatch) {
        return res.status(400).json({ message: 'Email ou mot de passe incorrect' });
      }

      // Si authentification réussie, redirection en fonction du statut
      if (user.statut === 'patient') {
        return res.status(200).json({ message: 'Connexion réussie', redirect: '/accueil.html' });
      } else if (user.statut === 'secretaire') {
        return res.status(200).json({ message: 'Connexion réussie', redirect: '/secretaire.html' });
      } else {
        return res.status(400).json({ message: 'Statut inconnu' });
      }
    });
  });
});
app.get('/accueil.html', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'acceuil.html'));
});

// Démarrer le serveur
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
