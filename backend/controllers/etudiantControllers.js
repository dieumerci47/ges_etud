const pool = require("../database/mysql");

module.exports.getAllEtudiants = async (req, res) => {
    try{
     /* const { id } = req.body;
     console.log(req.body);
     console.log(id);
      */
         const data = await pool.query('SELECT * FROM v_etudiants');
        if (data[0].length === 0) {
            console.log("admin not found");
            return res.status(404).json({ error: 'admin not found' });
        }
        const admin = data[0];
        
        res.status(200).json(admin);
}catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Admin not connected' });
    }  
};
module.exports.getOneEtudiant = async (req, res) => {
    try{
        const { id } = req.params;
     /* 
     console.log(req.body);
     */
    //  console.log(id);
         const [row] = await pool.query('SELECT * FROM v_etudiants WHERE id=?',[id]);
        if (row.length === 0) {
            console.log("Etudiant not found");
            return res.status(404).json({ error: 'Etudiant not found' });
        }
        const etudiant = row[0];
        
        res.status(200).json(etudiant);
}catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Admin not connected' });
    }  
};
module.exports.getDashboard = async (req, res) => {
    try{
     /* const { id } = req.body;
     console.log(req.body);
     console.log(id);
      */
         const data = await pool.query("SELECT * FROM v_dashboard_home");
        if (data[0].length === 0) {
            console.log("admin not found");
            return res.status(404).json({ error: 'admin not found' });
        }
         const dash = await pool.query("SELECT * FROM v_stats_globales");
        if (dash[0].length === 0) {
            console.log("Stats Dash not found");
            return res.status(404).json({ error: 'Stats Dash not found' });
        }
         const promotions = await pool.query("SELECT * FROM v_stats_promotion");
        if (promotions[0].length === 0) {
            console.log("Stats promotions not found");
            return res.status(404).json({ error: 'Stats promotions not found' });
        }

const recents_etudiants = JSON.parse(data[0][0].recents_etudiants);
        const total_etudiants = data[0][0].total_etudiants;
        const inscrits_ce_mois = data[0][0].inscrits_ce_mois;
        // const statsDash= [0][0]
        // console.log(statsDash);
        // Convertir les chaînes en nombres avant de renvoyer
  const statsDash = dash[0][0];
  for (const key in statsDash) {
    if (typeof statsDash[key] === 'string' && !isNaN(statsDash[key])) {
      statsDash[key] = parseInt(statsDash[key], 10);
    }
  }

  const statsPromotion=promotions[0];
  
        // const statsDash=JSON.parse(dash[0][0]);
        
        res.status(200).json({total_etudiants,inscrits_ce_mois, recents_etudiants,statsDash,statsPromotion});
}catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Admin not connected' });
    }  
};